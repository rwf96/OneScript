﻿/*----------------------------------------------------------
This Source Code Form is subject to the terms of the 
Mozilla Public License, v.2.0. If a copy of the MPL 
was not distributed with this file, You can obtain one 
at http://mozilla.org/MPL/2.0/.
----------------------------------------------------------*/

using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace ScriptEngine.Machine
{
    public class CodeStatProcessor : ICodeStatCollector
    {
        private Dictionary<CodeStatEntry, int> _codeStat = new Dictionary<CodeStatEntry, int>();
        private readonly string _outputFileName;
        private HashSet<string> _preparedScripts = new HashSet<string>();

        public CodeStatProcessor(string fileName)
        {
            _outputFileName = fileName;
        }

        public bool IsPrepared(string ScriptFileName)
        {
            return _preparedScripts.Contains(ScriptFileName);
        }

        public void MarkEntryReached(CodeStatEntry entry, int count = 1)
        {
            int oldValue = 0;
            _codeStat.TryGetValue(entry, out oldValue);
            _codeStat[entry] = oldValue + count;
        }

        public void MarkPrepared(string ScriptFileName)
        {
            _preparedScripts.Add(ScriptFileName);
        }

        public void OutputCodeStat()
        {

            var w = new StreamWriter(_outputFileName);
            var jwriter = new JsonTextWriter(w);
            jwriter.Formatting = Formatting.Indented;

            jwriter.WriteStartObject();
            foreach (var source in _codeStat.GroupBy((arg) => arg.Key.ScriptFileName))
            {
                jwriter.WritePropertyName(source.Key, true);
                jwriter.WriteStartObject();

                jwriter.WritePropertyName("path");
                jwriter.WriteValue(source.Key);
                foreach (var method in source.GroupBy((arg) => arg.Key.SubName))
                {
                    jwriter.WritePropertyName(method.Key, true);
                    jwriter.WriteStartObject();

                    foreach (var entry in method.OrderBy((kv) => kv.Key.LineNumber))
                    {
                        jwriter.WritePropertyName(entry.Key.LineNumber.ToString());
                        jwriter.WriteValue(entry.Value);
                    }

                    jwriter.WriteEndObject();
                }
                jwriter.WriteEndObject();
            }
            jwriter.WriteEndObject();
            jwriter.Flush();

            _codeStat.Clear();
        }
    }
}
